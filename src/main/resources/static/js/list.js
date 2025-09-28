function selEvent() {
	  let selId = document.getElementById("selId").value;
	  let act = document.getElementById("act");
	  switch (selId) {
	    case '01':
	      act.innerHTML = '';
	      break;
	    case '02':
	      act.innerHTML =
	        '<select id="codeType" class="form-control">' +
	        '<option value="01">자유</option>' +
	        '<option value="02">익명</option>' +
	        '<option value="03">QnA</option>' +
	        '</select>';
	      break;
	    case '03':
	    case '04':
	    case '05':
	      act.innerHTML = '<input type="text" class="form-control">';
	      break;
		case '06': 
			act.innerHTML=
   	 			'<input type="text" id="startDate"  class="form-control d-inline-block" ><input type="text" id="endDate"  class="form-control d-inline-block" >';
		    break;
	}
}
//=== 최소 전역 상태 2개 ===
let prevPage = null;     // 마지막으로 실제로 데이터를 불러온 페이지
let pagerKey = null;       // 페이징 구조(필터, 검색어, 기간, 페이지크기 등)의 스냅샷

function readFilters(){
const selId = document.getElementById("selId").value;
const codeTypeEl = document.getElementById("codeType");
const context = document.getElementById("act").querySelector('input');
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");
const base = { selId, cnt: 10 };

	switch (selId) {
	  case '01':
	    return base;
	  case '02':
	    return { ...base, codeType: codeTypeEl ? codeTypeEl.value : "" };
	  case '03':
	    return { ...base, title: context ? context.value.trim() : "" };
	  case '04':
	    return { ...base, name: context ? context.value.trim() : "" };
	  case '05':
	    return { ...base, num: context ? context.value.trim() : "" };
	  case '06':
	    return {
	      ...base,
	      startDate: startDate ? startDate.value.trim() : "",
	      endDate: endDate ? endDate.value.trim() : ""
	    };
	  default:
	    return base;
	}
}
function buildPagerKey(filters) {
	  // 페이징 구조에 영향 주는 것만 포함 (selId, 각 필드, cnt)
	  // page는 포함 X
	  const { selId, codeType, title, name, num, startDate, endDate, cnt } = filters;
	  return JSON.stringify({ selId, codeType, title, name, num, startDate, endDate, cnt });
	}
//실제 페이지 데이터 로드 (무한루프 방지 핵심: 같은 페이지면 즉시 return)
function loadPage(page, { skipPagerInit = true }) {
  if (page === prevPage) return;   // onPageClick 중복·재귀 차단
  prevPage = page;

  const filters = readFilters();
  const payload = { ...filters, page };
  console.log('filters: ' + JSON.stringify(filters));
  console.log('payload: ' + JSON.stringify(payload));

  $.ajax({
    type: 'POST',
    url: 'search.ajax',
    contentType: 'application/json',
    dataType: 'json',
    data: JSON.stringify(payload),
    success: function (res) {
      drawList(res.list);
      // 서버가 totalPages를 같이 줌
      //console.log('res: ' + JSON.stringify(res));
		console.log('skipPagerInit: ' + skipPagerInit);
      // 페이지 이동에서 호출된 경우(skipPagerInit=true)에는 페이저를 건드리지 않음
      // (검색조건이 바뀌지 않았는데 destroy/init 하면 루프의 원인)
      if (!skipPagerInit) {
        initPager(res.totalPages); // 초기 진입이나 조건변경 시에만 초기화
      }
    },
    error: function (e) {
      console.error(e);
    }
  });
}

//리스트 렌더
function drawList(list) {
  const $list = $('#list');
  if (!list || list.length === 0) {
    $list.html('');
    $('#no-data').show();
    return;
  }
  let html = '';
  list.forEach(view => {
	  html += '<tr>';
	  html += '<td>' + (view.codeType ?? '') + '</td>';
	  html += '<td>' + (view.num ?? '') + '</td>';
	  html += '<td><a href="detail.do?num=' + (view.num ?? '') + '">' + (view.title ?? '') + '</a></td>';
	  html += '<td>' + (view.name ?? '') + '</td>';
	  html += '<td>' + (view.bHit ?? '') + '</td>';
	  html += '<td>' + (view.regdate ?? '') + '</td>';
	  html += '</tr>';
	});
  $list.html(html);
  $('#no-data').hide();
}
//페이저 초기화 (옵션이 바뀌었을 때만 호출)
function initPager(tp) {
  $('#pages').twbsPagination('destroy');
  $('#pages').empty();
  $('#pages').twbsPagination({
    startPage: 1,
    totalPages: tp ,
    visiblePages: 5,
    first: '<<',
    prev: '<',
    next: '>',
    last: '>>',
    // 초기화 직후 1페이지 onPageClick이 자동으로 한 번 호출됨
    // loadPage에서 prevPage 비교로 중복 로드를 자연스럽게 방지
    onPageClick: function (_, page) {
      loadPage(page, { skipPagerInit: true });
    }
  });
}
//[검색 버튼] 사용자가 조건을 바꿨을 때만 페이저 재초기화
function searchClick() {
  const filters = readFilters();
  const nextKey = buildPagerKey(filters);
/*   console.log('nextKey : '+nextKey);
  console.log('pagerKey : '+pagerKey);
  console.log('prevPage : '+prevPage);
 */
  if (nextKey !== pagerKey) {
    // 조건이 바뀌었으니 키 갱신하고 prevPage 리셋 후 재초기화
    pagerKey = nextKey;
    prevPage = null; // 초기화 전에 리셋해야 onPageClick(1)이 정상 동작
    // page=1을 로드하면서 페이저도 새로 깐다 (skipPagerInit=false)
    loadPage(1, { skipPagerInit: false });
  } else {
    // 조건이 같으면 페이저 그대로 두고 현재 페이지 데이터만 새로고침 하고 싶다면:
    const current = $('#pages').twbsPagination('getCurrentPage')|| 1;
    loadPage(current, { skipPagerInit: true });
  }
}