class CreateGameSeed < ActiveRecord::Migration[6.0]
  def change
    Embrace::Game.create(
      id: 1,
      en_name: 'Defense of the Ancients 2',
      name: '刀塔2',
      abbr: 'DotA2'
    )
    Embrace::Game.create(
      id: 2,
      en_name: 'League of Legends',
      name: '英雄联盟',
      abbr: 'LOL'
    )
    Embrace::Game.create(
      id: 3,
      en_name: 'Counter-Strike:Global Offensive',
      name: '反恐精英:全球攻势',
      abbr: 'CSGO'
    )
    Embrace::Game.create(
      id: 4,
      en_name: 'King of Glory',
      name: '王者荣耀',
      abbr: 'KOG'
    )
  end
end
