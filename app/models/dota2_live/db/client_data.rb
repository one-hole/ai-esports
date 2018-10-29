# 用来更新客户端的一些数据，主要是当客户端没有比赛时的补救措施

module Dota2Live
  module Db
    module ClientData

      def update_client_data(normal)
        if normal
          update_normal_client_data
        else
          update_reverse_client_data
        end
      end

      def update_normal_client_data
        if duration > db_duration
          # 时长
          @match.update(duration: duration)

          # 天辉领先
          @match.update(radiant_lead: radiant_lead)

          # 人头
          @match.update(left_team_kills: radiant_score) if radiant_score > db_left_team_kills
          @match.update(right_team_kills: dire_score) if dire_score > db_right_team_kills

          # 一血
          if db_left_team_first_blood.nil?
            @match.update(left_team_first_blood: true) if radiant_fb?
            @match.update(left_team_first_blood: false) if dire_db?
          end

          # 十杀
          if db_left_team_ten_kills.nil?
            @match.update(left_team_ten_kills: true) if radiant_ten_kills?
            @match.update(left_team_ten_kills: false) if dire_ten_kills?
          end
        end
      end

      def update_reverse_client_data
        if duration > db_duration
          # 时长
          @match.update(duration: duration)

          # 天辉领先
          @match.update(radiant_lead: radiant_lead)

          # 人头
          @match.update(left_team_kills: dire_score) if dire_score > db_left_team_kills
          @match.update(right_team_kills: radiant_score) if radiant_score > db_right_team_kills

          # 一血
          if db_left_team_first_blood.nil?
            @match.update(left_team_first_blood: false) if radiant_fb?
            @match.update(left_team_first_blood: true) if dire_db?
          end

          # 十杀
          if db_left_team_ten_kills.nil?
            @match.update(left_team_ten_kills: false) if radiant_ten_kills?
            @match.update(left_team_ten_kills: true) if dire_ten_kills?
          end
        end
      end

      def radiant_fb?
        radiant_score >= 1 && dire_score == 0
      end

      def dire_db?
        dire_score >= 1 && radiant_score == 0
      end

      def radiant_ten_kills?
        radiant_score >= 10 && dire_score < 10
      end

      def dire_ten_kills?
        dire_score >= 10 && radiant_score < 10
      end

    end
  end
end