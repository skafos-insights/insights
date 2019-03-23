function join_by { local IFS="$1"; shift; echo "$*"; }

joined=''

for s in $(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" .env); do
  joined=$(join_by ' ' $joined $s)
  export $s
done

echo $joined

if [ "$1" = "remote" ]; then
  gigalixir config:set $joined
fi