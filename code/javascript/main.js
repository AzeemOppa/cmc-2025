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

async function cmc_link_generate(content, archive_name)
{
  const link = document.createElement("a");
  link.href = URL.createObjectURL(content);
  link.download = archive_name;
  link.click();
  URL.revokeObjectURL(link.href);
}

async function cmc_zip_generate(files, folder_name, archive_name)
{
  const zip = new JSZip();
  const folder = zip.folder(folder_name);
  await cmc_archive_setup(folder, files);
  const content = await zip.generateAsync({ type: "blob" });
  cmc_link_generate(content, archive_name);
  return 
}

async function cmc_download(files, folder_name, archive_name, element_id, event)
{
  const generate = () => cmc_zip_generate(files, folder_name, archive_name);
  const element = document.getElementById(element_id);
  element.addEventListener(event, generate);
}

cmc_download(
  cmc_files,
  "cmc-2025-website",
  "cmc-2025-website.zip",
  "cmc-download-button",
  "click");
