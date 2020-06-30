\redis-cli -h "${REDIS_ADDR//:6379}" -n "$REDIS_DB" --eval moveMultiElementsToOtherSet.lua
