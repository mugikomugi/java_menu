// 表示用vew画面JavaScript Document
$(function () {

  //Menuタブ切り替え
  $('.vewCattab li').on('click', function () {
    let tabID = $(this).attr('data-id');
    if ($(this).hasClass('none')) {
      $(this).attr('class', 'act').siblings().attr('class', 'none');
    }
    $('.vewMenu').parent().attr('class', 'noActive');
    $('#' + tabID).removeClass('noActive').addClass('active');
  });

  //注文票モーダル
  let orderMenu = {};
  let i = 1;

  const overlay = $('.overlay');
  const orderList = $('.orderList');
  const cashList = $('.cashList');
  const oderBox = $('.orderBox');
  const cashBox = $('.cashBox');

  $('.menuBox').on('click', function () {
    let order = $('.menuName', this).text();
    let money = $('.vewPrice', this).attr('data-price');

    // すでに同じメニュー名が存在するか確認
    let isSame = Object.keys(orderMenu).some(function (key) {
      return orderMenu[key].title === order;
    });
    //重複していたらここで処理を中断（追加しない）
    if (isSame) {
      return;
    }

    // オブジェクトcountに要素を追加、個数countもデータに追加
    orderMenu['order' + i] = { title: order, price: parseInt(money), count: 1 };
    i++;
    orderBox();

    // メニューが追加されたのでお会計ボタンを表示する
    $('#cash').show();
    $('.notes', orderList).text('「メニューを見る」ボタンで追加注文できます。');

    overlay.fadeIn();
    orderList.fadeIn();
  });

  // 動的に追加された input[name="num"] のリアルタイム変更を検知（イベント委譲）
  oderBox.on('input', 'input[name="num"]', function () {
    let li = $(this).closest('li');
    //parent()は1つ上の階層にある親要素を取得する
    //closest()は特定の親要素を見つけるまで階層を辿っていく
    let key = li.data('key');
    let num = parseInt($(this).val()) || 0;

    // 個数が0（または空文字）の場合
    if (num <= 0) {
      delete orderMenu[key]; // オブジェクトから削除
      li.remove(); // 画面のli要素を削除
      // 注文がすべてなくなった場合会計ボタン非表示
      if (Object.keys(orderMenu).length === 0) {
        $('#cash').hide();
        $('.notes', orderList).text('メニュー画面から注文を入れてください。');
      }
    } else {
      if (orderMenu[key]) {
        orderMenu[key].count = num;
      }
    }
  });

  // 描画用関数（個数データとliへのdata-key付与を追加）
  function orderBox() {
    oderBox.empty();
    Object.keys(orderMenu).forEach(function (key) {
      let item = orderMenu[key];
      let unitPrice = item.price.toLocaleString();
      let taxPrice = item.price * 1.1;
      oderBox.append(
        '<li data-key="' + key + '"><p class="menuItem">' +
        item.title + '<span class="onePrice">' + unitPrice + '円</span><span class="taxPrice">（税込' + taxPrice.toLocaleString() + '円）</span></p>' +
        '<p class="numBox"><input type="number" min="0" value="' + item.count + '" name="num">個' +
        '</p></li>'
      );
    });
  }

  //メニューを見るbtn
  $('#toMenu').on('click', function () {
    overlay.fadeOut();
    orderList.fadeOut();
  });

  //お会計
  $('#cash').on('click', function () {
    // 会計に進む前に count が 0 以下の要素を除外する
    Object.keys(orderMenu).forEach(function (key) {
      if (!orderMenu[key].count || orderMenu[key].count <= 0) {
        delete orderMenu[key];
      }
    });

    // 有効な注文が存在しない（オブジェクトが空）かチェック
    /*
        if (Object.keys(orderMenu).length === 0) {
          alert('注文が入っていません。');
    
          overlay.fadeOut();
          orderList.fadeOut();
          return;
        }
    */
    // 注文票（ orderList ）とオーバーレイを非表示にして閉じる
    // returnここで処理を中断し、会計画面（cashList）には進まない

    let totalPrice = 0; // 合計金額用の変数
    cashBox.empty(); // 毎回追加されて重複するのを防ぐために空にする
    let taxTotal;

    Object.keys(orderMenu).forEach(function (key) {
      let item = orderMenu[key];
      let subtotal = item.price * item.count; // 小計を計算
      totalPrice += subtotal; // 合計に加算
      taxTotal = totalPrice * 1.1;

      cashBox.append(
        '<li data-key="' + key + '"><p>' +
        item.title + '：' + item.price.toLocaleString() + '円 ' +
        '<span class="onePrice"> × ' + item.count + ' 個</span></p><p class="">計 ' + subtotal.toLocaleString() +
        '円</p></li>'
      );
    });
    $('.total').html('<p>小計 ' + totalPrice.toLocaleString() + '円</p><p>税金 ' + Math.floor(totalPrice * 0.1).toLocaleString() + '円</p><p class="lastTotal">合計 ' + Math.floor(taxTotal).toLocaleString() + '円</p>');

    orderList.fadeOut();
    cashList.fadeIn();
    //console.log(orderMenu);
  });

  //注文票に戻る
  $('#toBack').on('click', function () {
    cashList.fadeOut();
    orderList.fadeIn();
  });

  //確定 オブジェクトを空にする
  $('#practice').on('click', function () {
    $('.thanks').fadeIn();
    cashList.fadeOut();
    orderMenu = {};
  });

  //thanksページ表示
  $('#toList').on('click', function () {
    overlay.fadeOut();
    $('.thanks').fadeOut();
    console.log(orderMenu);
  });

});

