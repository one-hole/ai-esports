class DotaLiveService
  def initialize(series_id, round, left_score, right_score)
    @series_id, @round = series_id, round
    @left_score, @right_score = left_score, right_score
  end

  def run
    resp = build_lives(@series_id, @round)
    (0..(@left_score + @right_score - 1)).each do |i|
      resp[:matches][i][:data]["status"] = "finished"
    end
    resp.to_json
  end

  private
    def call_live(series_id, game_no)
      api_path = "http://api.ouresports.com/api/v2/live/dota/#{series_id}?game_no=#{game_no}"
      request = Typhoeus::Request.new(
          api_path,
          method: :get,
          headers: { Accept: "text/html" }
        )
      resp = request.run
      code = resp.code

      return nil if code != 200

      return {
        data: JSON.parse(resp.body)['match']
      } if code == 200
    end

    def matches_array(series_id, round)
      ary = []
      (1..round).each do |game_no|
        ary << call_live(series_id, game_no)
      end
      ary
    end

    def build_lives(series_id, round)
      {
        id: series_id,
        matches: matches_array(series_id, round).compact
      }
    end
end
