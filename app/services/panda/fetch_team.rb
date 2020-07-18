module Panda
  class FetchTeam
    def self.run
      fetch_lol_team
      fetch_dota_team
      fetch_csgo_team
    end

    def self.fetch_lol_team
      (1..18).each do |page|
        resp = Request.get('https://api.pandascore.co/lol/teams', page)
        lol_handler(resp) if resp.code == 200
      end
    end

    def self.fetch_dota_team
      (1..18).each do |page|
        resp = Request.get('https://api.pandascore.co/dota2/teams', page)
        dota_handler(resp) if resp.code == 200
      end
    end

    def self.fetch_csgo_team
      (1..18).each do |page|
        resp = Request.get('https://api.pandascore.co/csgo/teams', page)
        dota_handler(resp) if resp.code == 200
      end
    end

    private

    def self.csgo_handler(resp)
      JSON.parse(resp.body).each do |csgo_team|
        team = Embrace::Team.find_by(third_id: csgo_team['id'])
        next if team

        Embrace::Team.create(
          third_id: csgo_team['id'],
          game_id: 3,
          image: csgo_team['image_url'],
          country: csgo_team['location'],
          name: csgo_team['name'],
          abbr: csgo_team['acronym'],
          snd_name: csgo_team['slug']
        )
      end
    end

    def self.dota_handler(resp)
      JSON.parse(resp.body).each do |dota_team|
        team = Embrace::Team.find_by(third_id: dota_team['id'])
        next if team

        Embrace::Team.create(
          third_id: dota_team['id'],
          game_id: 1,
          image: dota_team['image_url'],
          country: dota_team['location'],
          name: dota_team['name'],
          abbr: dota_team['acronym'],
          snd_name: dota_team['slug']
        )
      end
    end

    def self.lol_handler(resp)
      JSON.parse(resp.body).each do |lol_team|
        team = Embrace::Team.find_by(third_id: lol_team['id'])
        next if team

        Embrace::Team.create(
          third_id: lol_team['id'],
          game_id: 2,
          image: lol_team['image_url'],
          country: lol_team['location'],
          name: lol_team['name'],
          abbr: lol_team['acronym'],
          snd_name: lol_team['slug']
        )
      end
    end
  end
end

# PerPage 50
# LOL   18 页 11 个对象(已经抓完)
# DotA  18 页 21 个对象(已经抓完)
# CSGO  17 页 50 个对象(已经抓完)