### Dota2 Live
---
#### LiveLeagueGame

1. SeriesWin 这个字段不是那么的准
2. BP 阶段这个数据是最快的
3. Duration 在 BP 的时候持续显示为 0 

#### Xml:

---
#### TopLiveGames

1. 不一定有数据
2. BP 的时候时间会持续增加

###### RealTime

1. 必须基于 TopLiveGames 才会有的数据
2. 数据最全（包括队伍的 Logo、队员的名字）
3. BP 的时候时间会持续增加


如果 BP 数据都是满的 。那么以 Duration 为准进行更新
如果 BP 数据没有满。那么 Duration 始终是 0