\redis-cli -h mongo -n 1 --eval zinterstoreMemberStocksEffectRank.lua , $(date +'%Y%m%d')
