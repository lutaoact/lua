\redis-cli -h mongo -n 1 --eval zinterstoreStockZhangFuRankForMemberStocks.lua
# crontab中的配置行参考
# * * * * * . ~/.bash_profile && cd ~/lua && PATH=/usr/local/bin:$PATH sh zinterstoreStockZhangFuRankForMemberStocks.sh >> /data/log/zinterstoreStockZhangFuRankForMemberStocks.log 2>&1
