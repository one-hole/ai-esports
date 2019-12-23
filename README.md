TODO:

1. Duration
2. Player Not Uniq By AccountID

完善数据补全的机制、明确不同的 API 能提供的数据范围


CSGO 的处理机制

1. T2Score 拿比赛（如果存在 Live 那么不用 T2 的数据来更新）
2. 有 Live 的话（其实也是全量更新）


[X] 1. 大比分已经是 1 : 0 了 但是小比分没有打完 

[X] 2. 加时的情况

[]  3. Live 的辅助修订

如果当前的 CsgoMatchDetail 里面的数据为空 并且 新拿到的数据的上半场和上一把一样

如果没有 Status 那么就不创建