##!/bin/bash
header="1"
number="2"
processFunc()
{
  local x=$1
  local y=$2
  if  ( [ "$x" == "0" ] || [ "$x" == "$y" ] ) && ( [ ! -z $y ] || [ ! -z $x ] )
  then
    return 1
  fi
  if [ "$y" == "" ] && [ "$x" == "" ]
  then 
    #No input parameters provided, therefore taking the process ID of the current process
    ps_info="$(ps -f | tail -n +$header | head -n $number)"
    parent_id="$(ps -o ppid= | tail -n +1 | head -n 1)"
    #Check for validity/accessibility of process ID
    if [ "$ps_info" == "" ]
    then
      echo "Invalid process ID or process ID cannot be accessed.  Exiting program..."
      return 2
    fi
    #Remove header from remaining calls
    if [ "$header" == "1" ]
    then
      header="2"
      number="1"
      ps_info_t="$(ps -f $x | tail -n +$header | head -n $number)"
      #Check for validity/accesibility of first process
      if [ "$ps_info_t" == "" ]
      then
	 echo "Invalid process ID or process ID cannot be accessed.  Exiting program..."
	 return 2
      fi
    fi
    #Display process tree node
    echo "$ps_info"
    #Recursive call to parent process id
    processFunc $parent_id
    return 0
  elif [ "$y" == "" ]
  then
    #One input parameters provided
    parent_id="$(ps -o ppid= $x | tail -n +1 | head -n 1)"
    ps_info="$(ps -f $x | tail -n +$header | head -n $number)"
    #Check for validity/accessibility of process ID
    if [ "$ps_info" == "" ]
    then
      echo "Invalid process ID or process ID cannot be accessed.  Exiting program..."
      return 2
    fi 
    #Remove header from remaining calls
    if [ "$header" == "1" ]
    then
      header="2"
      number="1"
      ps_info_t="$(ps -f $x | tail -n +$header | head -n $number)"
      if [ "$ps_info_t" == "" ]
      then
	 echo "Invalid process ID or process ID cannot be accessed.  Exiting program..."
	 return 2
      fi
    fi
    #Display process tree node
    echo "$ps_info"
    #Recursive call to parent process id
    processFunc $parent_id
    return 0
  else
    #Both input parameters provided
    parent_id="$(ps -o ppid= $x | tail -n +1 | head -n 1)"
    ps_info="$(ps -f $x | tail -n +$header | head -n $number)"
    ps_info_y="$(ps -f $y | tail -n +$header | head -n $number)"
    #Check for validity/accessibility of process ID
    if [ "$ps_info" == "" ] || [ "$ps_info_y" == "" ]
    then
      echo "Invalid process ID or process ID cannot be accessed.  Exiting program..."
      return 2
    fi
    #Remove header from remaining calls
    if [ "$header" == "1" ]
    then
      header="2"
      number="1"
      ps_info_t="$(ps -f $x | tail -n +$header | head -n $number)"
      ps_info_ty="$(ps -f $y | tail -n +$header | head -n $number)"
      #Check for validity/accesibility of first process
      if [ "$ps_info_t" == "" ] || [ "$ps_info_ty" == "" ]
      then
	 echo "Invalid process ID or process ID cannot be accessed.  Exiting program..."
	 return 2
      fi
    fi
    #Display process tree node
    echo "$ps_info"
    #Recursive call to parent process id
    processFunc $parent_id $y
    return 0
  fi
}
processFunc $1 $2
