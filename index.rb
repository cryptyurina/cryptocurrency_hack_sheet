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
SPREADSHEET_ID= '1Nu6HLHrX2W9IK2ACg61ZP6COo59WfeJOp-t0QFs03Zg'

service = Google::Apis::SheetsV4::SheetsService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = Authorization.new
# Prints the names and majors of students in a sample spreadsheet:
# https://docs.google.com/spreadsheets/d/1MNX3EHGmf3SPDA-GixWcrTPY1yO3nDnk-SqBq488VHA/edit


def execute_cryptopia(service)
  client = Client.new(API::CRYPTOPIA::BASE)
  res = client.get API::CRYPTOPIA::GET_ALL_CURRENCIES
  results = JSON.parse(res.body)
  rows = Parse::Cryptopia.get_currencies(results)
  requests = []
  rows.each_slice(OBJECT_COUNT) do |row|
    requests.push({
      update_cells: {
        start: {sheet_id: 1365869093, row_index: 2, column_index: 0},
        rows: row[0],
        fields: 'userEnteredValue'
      }
    })
  end
  batch_update_request = {requests: requests}
  service.batch_update_spreadsheet(SPREADSHEET_ID, batch_update_request, {})
end

def execute_binance(service)
  client = Client.new(API::BINANCE::BASE)
  res = client.get API::BINANCE::GET_EXCHANGE_INFO
  results = JSON.parse(res.body)
  rows = Parse::Binance.get_currencies(results)
  requests = []
  rows.each_slice(OBJECT_COUNT) do |row|
    requests.push({
      update_cells: {
        start: {sheet_id: 0, row_index: 2, column_index: 0},
        rows: row[0],
        fields: 'userEnteredValue'
      }
    })
  end
  batch_update_request = {requests: requests}
  service.batch_update_spreadsheet(SPREADSHEET_ID, batch_update_request, {})
end

execute_cryptopia(service)
execute_binance(service)
