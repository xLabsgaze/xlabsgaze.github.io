kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')
clear

echo "Building Docs xLabs API website..."
jekyll build --config configs/docs/config_xlabs_api.yml
# jekyll serve --config configs/docs/config_xlabs_api.yml
echo "done"

echo "All finished building all the web outputs!!!"
echo "Now push the builds to the server with . mydoc_4_publish.sh"

