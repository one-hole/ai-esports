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
          radiant_picks: get_radiant_picks(match),
          radiant_bans:  get_radiant_bans(match),
          dire_score:    get_dire_score(match),
          dire_picks:    get_dire_picks(match),
          dire_bans:     get_dire_bans(match),
          duration:      get_duration(match),
          radiant_net_worth: get_radiant_net_worth,
          dire_net_worth:    get_dire_net_worth
        )

        match.add_diff

        process_team(@radiant_team_infos, match.battle_id)
        process_team(@dire_team_infos,    match.battle_id)

      end

      # 存在一种情况 。就是 BP 的时候持续进行
      def can_update?(match)
        @can_update ||= @battle_info["match"]["game_time"] > match.duration.to_i
      end

      def get_radiant_net_worth
        @radiant_team_infos["net_worth"]
      end

      def get_dire_net_worth
        @dire_team_infos["net_worth"]
      end

      def get_radiant_score(match)
        if can_update?(match)
          [match.radiant_score.to_i, @radiant_team_infos["score"]].max
        else
          match.radiant_score
        end
      end

      def get_dire_score(match)
        if can_update?(match)
          [match.dire_score.to_i, @dire_team_infos["score"]].max
        else
          match.dire_score
        end
      end

      def get_duration(match)
        if (can_update?(match) && match.bp_over?)
          @battle_info["match"]["game_time"]
        else
          match.duration
        end
      end

      def get_radiant_picks(match)
        begin
          @battle_info["match"]["picks"].select { |item| item["team"] == 2 }.map { |item| item["hero"] }
        rescue => e
          puts "Real Time get_radiant_picks"
          puts e
          return match.radiant_picks
        end
      end

      def get_radiant_bans(match)
        begin
          @battle_info["match"]["bans"].select { |item| item["team"] == 3 }.map { |item| item["hero"] }
        rescue => e
          puts "Real Time get_radiant_bans"
          puts e
          return match.radiant_bans
        end
      end

      def get_dire_picks(match)
        begin
          @battle_info["match"]["picks"].select { |item| item["team"] == 3 }.map { |item| item["hero"] }
        rescue => e
          puts "Real Time get_dire_picks"
          puts e
          return match.dire_picks
        end
      end

      def get_dire_bans(match)
        begin
          @battle_info["match"]["bans"].select { |item| item["team"] == 3 }.map { |item| item["hero"] }
        rescue => e
          puts "Real Time get_dire_bans"
          puts e
          return match.dire_bans
        end
      end

    end
  end
end

# 更新 Match 之前
#
# Duration / DireScore / RadiantScore