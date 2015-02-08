#!/usr/bin/env sh
#
# Chicago Boss Init System
#
# @author: Jose Luis Gordo Romero <jgordor@gmail.com>
# @author: Rune Juhl Jacobsen <rune@juhljacobsen.dk>
#
# -------------------------------------------------------------------
# The shell commands are automatically generated by the boss rebar 
# plugin/driver, all configuration params and paths are in boss.config
# -------------------------------------------------------------------

do_start () {
    if test $(echo "$1"|grep "^exec erl"> /dev/null;echo $?) -eq 0
    then
        eval "$1"
    else
        echo "$1"
    fi
}


cd `dirname $0`

case "${1:-''}" in
  'start')
        # Start Boss in production mode
        echo "starting boss in production mode..."
        START=$(rebar boss c=start_cmd|grep -v "==>")
        do_start "$START"
        ;;
        
  'start-dev')
        # Start Boss in development mode
        START_DEV=$(rebar boss c=start_dev_cmd|grep -v "==>")
        do_start "$START_DEV"
        ;;

  'stop')
        # Stop Boss daemon
        echo "stopping boss..."
        STOP=$(rebar boss c=stop_cmd|grep -v "==>")
        # After hours of shell quoting problems with the erl command,
        # eval with the command quoted works!!!
        do_start "$STOP"
        ;;

  'reload')
        # Boss hot code reload <-- only the actual node, not the entire cluster
        echo "Hot code reload, (WARN: Only this node)"
        RELOAD=$(rebar boss c=reload_cmd|grep -v "==>")
        do_start "$RELOAD"
        ;;

  'restart')
        # Boss complete restart
        echo "Restarting (stop-start) boss..."
        $0 stop
        $0 start
        ;;

  'attach')
        # Boss attach running system's console
        echo "Connecting production system..."
        ATTACH=$(rebar boss c=attach_cmd|grep -v "==>")
        do_start "$ATTACH"
        ;;

  *)
        echo "Chicago Boss Boot System"
        echo "Usage: $SELF start|start-dev|stop|reload|restart|attach"
        exit 1
        ;;
esac
