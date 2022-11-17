#!/usr/bin/env python
# -*- coding:utf-8 -*-
"""create_form.py

Script to create a new BM432 question form using JSON data for an
existing Google Form.

This was tested under Leighton's "Google Forms for Teaching" project
in Google Cloud, following guidance at:

https://developers.google.com/docs/api/quickstart/python

and

https://developers.google.com/forms/api/quickstart/python
"""

import json

from pathlib import Path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# If modifying these scopes, delete the file token.json.
SCOPES = "https://www.googleapis.com/auth/forms.body"

# Path to template file for the Google Form
TEMPLATE = Path("bm432_google_form.json")

# Path to local JSON copy for future editing
OUTPUTPATH = Path("bm432_form_2023.json")


def load_template(fpath):
    with fpath.open() as ifh:
        template = json.load(ifh)
    return template


creds = None
if Path("token.json").exists():
    creds = Credentials.from_authorized_user_file("token.json", SCOPES)
if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
        creds.refresh(Request())
    else:
        flow = InstalledAppFlow.from_client_secrets_file("credentials.json", SCOPES)
        creds = flow.run_local_server(port=0)
    # Save the credentials for the next time
    with open("token.json", "w") as token:
        token.write(creds.to_json())

try:
    service = build("forms", "v1", credentials=creds)

    # Load BM432 template
    template = load_template(TEMPLATE)

    # Request body for creating a form
    info = template["info"]
    form_info = {
        "info": {"title": info["title"], "documentTitle": info["documentTitle"]}
    }

    # Create initial form from info
    result_formid = service.forms().create(body=form_info).execute()

    # Process items from the template form, removing UIDs as we go
    locidx = 0  # location to insert the next item
    for item in template["items"]:
        del item["itemId"]  # item-specific UID

        # Now remove UIDs specific to the item type
        if "questionItem" in item:
            del item["questionItem"]["question"]["questionId"]
        else:  # placeholder if we need to add new items to this filter
            pass

        # Create a new request for the item and add to the form
        form_request = {
            "requests": [{"createItem": {"item": item, "location": {"index": locidx}}}]
        }
        print(f"Adding item {item['title']}")
        service.forms().batchUpdate(
            formId=result_formid["formId"], body=form_request
        ).execute()
        locidx += 1  # increment location index

    # Write JSON version of form to local output
    form_json = service.forms().get(formId=result_formid["formId"]).execute()
    with OUTPUTPATH.open("w") as ofh:
        json.dump(form_json, ofh)

    print(f"\nThe form has ID: {form_json['formId']}")
    print(f"View at: {form_json['responderUri']}")
    print(f"Edit via: https://docs.google.com/forms/d/{form_json['formId']}/edit")

except HttpError as err:
    print(err)
