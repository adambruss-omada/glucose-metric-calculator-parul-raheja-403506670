class GlucoseMetricsController < ApplicationController
    def show
      member = Member.find_by(id: params[:id])
  
      unless member
        render json: { error: "Member not found" }, status: :not_found
        return
      end
  
      service = GlucoseMetricsService.new(member.id)
  
      metrics = {
        average_glucose: service.average_glucose,
        below_range: service.percent_below_range,
        above_range: service.percent_above_range
      }
  
      render json: metrics
    end
end