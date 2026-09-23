// ダッシュボードJavaScript Document
$(function () {

  //カテゴリtab初期値
  let actUlID = $('.actCat').attr('data-id');
  $('#' + actUlID + '.detail').show();

  $('.catTab li').on('click', function () {
    actUlID = $(this).attr('data-id');
    $(this).attr('class', 'actCat').siblings().attr('class', 'none');
    $('#' + actUlID + '.detail').show().siblings('.detail').hide();
  });

  //サブカテゴリ初期値
  const subCat = $('#subCat');
  const noMain = $('.noMain');

  //メインのサブカテゴリ選択
  function subCatChange(selectName) {
    $(selectName).on('change', function () {
      let menu = $(this).val();
      if (menu == 'メイン') {
        subCat.val('お肉').trigger('change');
        noMain.hide().siblings('option').show();
      } else {
        noMain.show().siblings('option').hide();
        subCat.val('').trigger('change');
      }
    });
  }
  subCatChange('select[name="addCat"]');
  subCatChange('select[name="editCat"]');

});