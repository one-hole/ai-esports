GetRealtimeStats
这个数据比较快、而且有队伍的 Logo
但是需要 server_steam_id 可以从 GetTopLiveGame 里面拿

GetTopLiveGame（循环拉取即可）
这个比分是最快的
有比赛开始的时间 
{ 
  activate_time 
  match_id
  last_update_time
  radiant_lead
  MMR: 队伍评分
  radiant_score
  dire_score
  building_state
  players: 暂时可以忽略 因为只有 Player 的英雄信息
}

GetLiveLeagueGames（15s 拉一次即可）