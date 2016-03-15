echo 'Killing all Jekyll instances'
kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')
clear

echo "Building PDF-friendly HTML site for Docs xLabs-API ..."
jekyll serve --detach --config configs/docs/config_xlabs_api.yml,configs/docs/config_xlabs_api_pdf.yml
echo "done"

echo "All done serving up the PDF-friendly sites. Now let's generate the PDF files from these sites."
echo "Now run . mydoc_2_multibuild_pdf.sh"