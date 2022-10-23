class ApplicationController < ActionController::API
    def create_hash #v2
        # return if params.keys.include?(:transaction_hash)
        token = nil
        loop do
          token = SecureRandom.hex
          break unless FinancialTransaction.all.pluck(:transaction_hash).include?(token)
        end
        token
      end
end
