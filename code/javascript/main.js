async function cmc_archive_setup(folder, files)
{
  for (const file of files)
  {
    try
    {
      const response = await fetch(file);
      if (!response.ok)
        throw new Error(`Failed to fetch ${file}`);
      const blob = await response.blob();
      const arrayBuffer = await blob.arrayBuffer();
      folder.file(file, arrayBuffer);
    }
    catch (error)
    {
      console.error("Error fetching file:", file, error);
    }
  }
}

async function cmc_link_generate(content)
{
  const link = document.createElement("a");
  link.href = URL.createObjectURL(content);
  link.download = "cmc-2025-website.zip";
  link.click();
  URL.revokeObjectURL(link.href);
}

async function cmc_zip_generate()
{
  const zip = new JSZip();
  const folder = zip.folder("cmc-2025-website");
  await cmc_archive_setup(folder, cmc_files);
  const content = await zip.generateAsync({ type: "blob" });
  cmc_link_generate(content);
}

document.getElementById('cmc_download_button')
        .addEventListener('click', cmc_zip_generate);
