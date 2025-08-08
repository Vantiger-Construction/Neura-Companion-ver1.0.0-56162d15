
# 📊 Google Sheets Sync Stub (Python)
import gspread
from oauth2client.service_account import ServiceAccountCredentials

def log_violation_to_sheet(user_id, input_text, strikes):
    scope = ['https://spreadsheets.google.com/feeds',
             'https://www.googleapis.com/auth/drive']
    creds = ServiceAccountCredentials.from_json_keyfile_name('credentials.json', scope)
    client = gspread.authorize(creds)

    sheet = client.open('NeuraViolationLogs').sheet1
    sheet.append_row([user_id, input_text, strikes])
    print("📤 Logged violation to Google Sheet.")

# NOTE: Requires 'credentials.json' from your Google Cloud Console.
