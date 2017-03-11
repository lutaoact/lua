\redis-cli -h mongo -n 1 --eval zinterstoreMemberStocksEffectRank.lua , $(date +'%Y%m%d')
# crontab中的配置行参考
# */10 * * * * . ~/.bash_profile && cd ~/lua && PATH=/usr/local/bin:$PATH sh zinterstoreMemberStocksEffectRank.sh >> /data/log/zinterstoreMemberStocksEffectRank.log 2>&1
