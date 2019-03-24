function join_by { local IFS="$1"; shift; echo "$*"; }

joined=''

for s in $(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" .env); do
  if [ "$1" = "remote" ]; then
    gigalixir config:set $s
  fi
  export $s
done

echo $joined

