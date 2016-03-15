
# Doc xLabs API
echo "Building Docs xLabs API PDF ..."
prince --javascript --input-list=../doc_outputs/docs/xlabs-api-pdf/prince-file-list.txt -o docs/files/docs_xlabs_api_pdf.pdf;
echo "done"

echo "All done building the PDFs!"
echo "Now build the web outputs: . mydoc_3_multibuild_web.sh"