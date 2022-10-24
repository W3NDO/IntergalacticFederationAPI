class ReportsController < ApplicationController
    def full_report
        transactions = format_full_report
        render json: {data: transactions}, status: :ok
    end

    def get_planets_report
        render json: format_planet_reports, status: :ok
    end

    def get_pilots_report
        render json: format_pilot_reports, status: :ok
    end

    private
    def format_full_report
        transactions = FinancialTransaction.all.order(created_at: :asc).includes(:contract)
        final_return = []
        transactions.each do |tx|
            description = tx.description
            contract = tx.contract
            ship = Ship.find(tx.ship_id)
            if tx.transaction_type == "resource_transport"
                final_return << "Contract #{contract.id} paid: #{contract.value_cents} " unless contract.nil?
            else
                final_return << "#{ship.pilot.name} bought fuel: #{tx.value_cents}"
            end
        end
        final_return
    end

    def format_planet_reports
        planets = Planet.all
        result = []
        planets.each do |p|
            sent = p.resources_sent
            received = p.resources_received
            result << {
                p.name => {
                    "sent" => sent,
                    "received" => received
                }
            }
        end
        result
    end

    def format_pilot_reports
        pilots = Pilot.all
        result = []
        pilots.each do |p|
            result << {
                p.name => p.totals
            }
        end
        result
    end
end
