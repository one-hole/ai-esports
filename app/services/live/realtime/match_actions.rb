require_relative "./team_actions.rb"

module Live
  module Realtime
    module MatchActions

      include TeamActions

      def process_match(match)

        @radiant_team_infos = @battle_info["teams"].select { |team| team["team_number"] == 2 }[0]
        @dire_team_infos    = @battle_info["teams"].select { |team| team["team_number"] == 3 }[0]

        match.update(
          radiant_score: get_radiant_score(match),
          radiant_picks: get_radiant_picks,
          radiant_bans:  get_radiant_bans,
          dire_score:    get_dire_score(match),
          dire_picks:    get_dire_picks,
          dire_bans:     get_dire_bans,
          duration:      get_duration(match),
          radiant_net_worth: get_radiant_net_worth,
          dire_net_worth:    get_dire_net_worth
        )

        process_team(@radiant_team_infos)
        process_team(@dire_team_infos)

      end

      def get_radiant_net_worth
        @radiant_team_infos["net_worth"]
      end

      def get_dire_net_worth
        @dire_team_infos["net_worth"]
      end

      def get_radiant_score(match)
        [match.radiant_score.to_i, @radiant_team_infos["score"]].max
      end

      def get_dire_score(match)
        [match.dire_score.to_i, @dire_team_infos["score"]].max
      end

      def get_duration(match)
        [@battle_info["match"]["game_time"], match.duration.to_i].max
      end

      def get_radiant_picks
        begin
          @battle_info["match"]["picks"].select { |item| item["team"] == 2 }.map { |item| item["hero"] }
        rescue => e
          puts e
        end
      end

      def get_radiant_bans
        begin
          @battle_info["match"]["bans"].select { |item| item["team"] == 3 }.map { |item| item["hero"] }
        rescue => e
          puts e
        end
      end

      def get_dire_picks
        begin
          @battle_info["match"]["picks"].select { |item| item["team"] == 3 }.map { |item| item["hero"] }
        rescue => e
          puts e
        end
      end

      def get_dire_bans
        begin
          @battle_info["match"]["bans"].select { |item| item["team"] == 3 }.map { |item| item["hero"] }
        rescue => e
          puts e
        end
      end

    end
  end
end

# 更新 Match 之前
#
# Duration / DireScore / RadiantScore