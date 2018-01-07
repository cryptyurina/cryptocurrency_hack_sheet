require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'faraday'
require 'json'
require './parse.rb'
require './api.rb'
require './authorization.rb'
require './http_client.rb'
include API
include Parse
include Authorization
include Client

APPLICATION_NAME = 'CryptoCurrency Hack Sheet'
OBJECT_COUNT = 500

service = Google::Apis::SheetsV4::SheetsService.new
request_body = Google::Apis::SheetsV4::ValueRange.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = Authorization.new
# Prints the names and majors of students in a sample spreadsheet:
# https://docs.google.com/spreadsheets/d/1MNX3EHGmf3SPDA-GixWcrTPY1yO3nDnk-SqBq488VHA/edit
spreadsheet_id = '1MNX3EHGmf3SPDA-GixWcrTPY1yO3nDnk-SqBq488VHA'

cryptopia_client = Client.new(API::CRYPTOPIA::BASE)
cryptopia_res = cryptopia_client.get API::CRYPTOPIA::GET_ALL_CURRENCIES
results = JSON.parse(cryptopia_res.body)
rows = Parse.cryptopia_get_currencies(results)

requests = []
rows.each_slice(OBJECT_COUNT) do |row|
  requests.push({
    update_cells: {
      start: {sheet_id: 0, row_index: 2, column_index: 0},
      rows: row[0],
      fields: 'userEnteredValue'
    }
  })
  batch_update_request = {requests: requests}
  service.batch_update_spreadsheet(spreadsheet_id, batch_update_request, {})
end
