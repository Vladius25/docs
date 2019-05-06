# !/bin/bash

if [ ! -d "venv" ]; then
  echo "Can't find venv. It will be created"
  ./init_venv.sh
fi
. venv/bin/activate
make clean
make html
echo ""

# We need to move css includes before js to prevent loading lag
# No idea how to fix this
for file in build/html/*html; do
    links=$(sed -n '/.*rel=\"stylesheet\"/p' $file)
    sed -i "/.*rel=\"stylesheet\"/d" $file
    awk -v line="$links" "1;/.*<title>/{ print line}" $file > $file.tmp
    mv $file.tmp $file
    echo $file updated 
done

