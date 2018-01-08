module Parse
  module Cryptopia
    def self.get_currencies(results)
      values = []
      rows   = []
      results["Data"].each do |item|
        values.push(
          {
            values: [
              {
                user_entered_value: {number_value: item["Id"]}
              },
              {
                user_entered_value: {string_value: item["Name"]}
              },
              {
                user_entered_value: {string_value: item["Symbol"]}
              },
              {
                user_entered_value: {string_value: item["Algorithm"]}
              },
              {
                user_entered_value: {number_value: item["WithdrawFee"]}
              },
              {
                user_entered_value: {number_value: item["MinWithdraw"]}
              },
              {
                user_entered_value: {number_value: item["MaxWithdraw"]}
              },
              {
                user_entered_value: {number_value: item["MinBaseTrade"]}
              },
              {
                user_entered_value: {number_value: item["DepositConfirmations"]}
              },
              {
                user_entered_value: {string_value: item["ListingStatus"]}
              },
              {
                user_entered_value: {string_value: item["Status"]}
              },
              {
                user_entered_value: {string_value: item["StatusMessage"]}
              }
            ]
          }
        )
      end
      rows.push(values)
    end
  end

  module Binance
    def self.get_currencies(results)
      values = []
      rows   = []
      results["symbols"].each do |item|
        next unless item["quoteAsset"] == "BTC"
        values.push(
          {
            values: [
              {
                user_entered_value: {string_value: item["baseAsset"]}
              },
              {
                user_entered_value: {string_value: item["quoteAsset"]}
              },
              {
                user_entered_value: {number_value: item["filters"][0]["minPrice"].to_f}
              },
              {
                user_entered_value: {number_value: item["filters"][0]["maxPrice"].to_f}
              },
              {
                user_entered_value: {number_value: item["filters"][0]["tickSize"].to_f}
              },
              {
                user_entered_value: {number_value: item["filters"][1]["minQty"]}
              },
              {
                user_entered_value: {number_value: item["filters"][1]["maxQty"]}
              },
              {
                user_entered_value: {number_value: item["filters"][1]["stepSize"]}
              },
              {
                user_entered_value: {number_value: item["filters"][2]["minNotilnal"]}
              }
            ]
          }
        )
      end
      rows.push(values)
    end
  end
end
