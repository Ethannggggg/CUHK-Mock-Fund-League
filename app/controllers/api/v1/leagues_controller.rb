module Api
  module V1
    class LeaguesController < BaseController
      # GET /api/v1/leagues
      # Returns a list of all leagues.
      def index
        @leagues = League.all

        render json: @leagues.map { |league|
          {
            id:               league.id,
            name:             league.name,
            description:      league.description,
            starting_capital: league.starting_capital,
            start_date:       league.start_date,
            end_date:         league.end_date,
            member_count:     league.league_memberships.count
          }
        }
      end

      # GET /api/v1/leagues/:id
      # Returns the details of a single league, including its members.
      def show
        @league = League.find(params[:id])

        render json: {
          id:               @league.id,
          name:             @league.name,
          description:      @league.description,
          starting_capital: @league.starting_capital,
          start_date:       @league.start_date,
          end_date:         @league.end_date,
          rules:            @league.rules,
          member_count:     @league.league_memberships.count,
          members:          @league.users.map { |user|
            { id: user.id, name: user.name, email: user.email }
          }
        }
      rescue ActiveRecord::RecordNotFound
        render json: { error: "League not found" }, status: :not_found
      end

      # POST /api/v1/leagues
      # Creates a new league.
      def create
        @league = League.new(league_params)

        if @league.save
          render json: {
            id:               @league.id,
            name:             @league.name,
            description:      @league.description,
            starting_capital: @league.starting_capital,
            start_date:       @league.start_date,
            end_date:         @league.end_date,
            rules:            @league.rules
          }, status: :created
        else
          render json: { errors: @league.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def league_params
        params.require(:league).permit(:name, :description, :starting_capital, :start_date, :end_date, rules: {})
      end
    end
  end
end

