import $ from 'jquery';
import 'select2';




function formatAsset(asset) {
  if (!asset.id) {
    return asset.text;
  }
  // console.log();
  console.log("super");
  let $asset = $(
    '<span><img src="' + asset.element.dataset.image + '" class="img-flag" /> ' + asset.text + '</span>'
  );
  return $asset;
};

const initSelect2 = () => {
  $('.select2').select2({
    templateResult: formatAsset,
    templateSelection: formatAsset,
    width: '170px',
    height: '38px'
  });
};

export { initSelect2 };
