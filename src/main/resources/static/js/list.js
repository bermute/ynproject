
function selEvent(){
let selId= document.getElementById("selId").value;
let act = document.getElementById("act");
	switch (selId) {
		case '02': 
			act.innerHTML=`
			<select id="selId2" class="form-control">
		    	<option value="01">자유</option>
		    	<option value="02">익명</option>
		    	<option value="03">QnA</option>
		    </select>
		    `;
			break;
		case '03': 
			act.innerHTML=`
   	 			<input type="text">
		    `;
			break;
		case '04': 
			act.innerHTML=`
   	 			<input type="text">
		    `;
		    break;
		case '05': 
			act.innerHTML=`
   	 			<input type="text">
		    `;
		    break;
		case '06': 
			act.innerHTML=`
   	 			<input type="text" id="startDate"><input type="text" id="endDate">
		    `;
		    break;
	}
}

let pagingInited = false; //추가
let cntPage = 0; //추가
function searchClick( show = 1 ){
let selId2 = document.getElementById("selId2");
let selId= document.getElementById("selId").value;
let context = document.getElementById("act").firstChild
let startDate = document.getElementById("startDate");
let endDate = document.getElementById("endDate");
let data = {};

	if (selId2) {
		selId2= selId2.value;	
	}
	if (context) {
		context= context.value;	
	}
	if (startDate && endDate){
		startDate = startDate.value;
		endDate = endDate.value;
	}
	
	//추가
	if (show === 1) {
		  pagingInited = false;
	}

	
	switch (selId) {
		case '02': 
		    data = {"codeType": selId2};
			break;
		case '03': 
			data = {"title": context };
			break;
		case '04': 
			data = {"name": context };
		    break;
		case '05': 
			data = {"num": context };
		    break;
		case '06': 
			data = {"startDate": startDate , "endDate" : endDate };
		    break;
	}
	console.log("startDate : "+startDate+ " endDate: " + endDate);
	data.page = show;
	data.cnt = 10;
	filter('search.ajax','post',data);	
}

filter('search.ajax','post',{"page" : 1 , "cnt" : 10 });
    function filter(url,type,data) {
        $.ajax({
            type: type,
            contentType: 'application/json',
            url: url,
            data: JSON.stringify(data),
            dataType: 'JSON',
            success: function(res) {
            //console.log(JSON.stringify(res));
                if (res.list.length > 0) {
                    drawList(res.list);
                  
                    //추가
                    if (!pagingInited || cntPage !== res.totalPages) {
					$('#pages').twbsPagination('destroy');                	
                    $('#pages').twbsPagination({
		                startPage:1, 
		                totalPages:res.totalPages, 
		                visiblePages:5,
		                initiateStartPageClick: false,
		                first:'<<',
		                prev:'<',
		                next:'>',
		                last:'>>',
		                onPageClick:function(evt,page){
		                   //console.log('evt',evt); 
		                   //console.log('page',page);
		                   searchClick(page);
		                }
                    });
                  	//추가
                    pagingInited = true;
                    cntPage = res.totalPages;
                  } 
                } else {
                    $('#list').html('');
                    $('#no-data').show();
                }
            },
            error: function(e) {
                console.error(e);
            }
        });
    }

    function drawList(list) {
        var content = '';
        list.forEach(function(view, idx) {
            content += '<tr>';
            content += '<td>' + view.codeType + '</td>';
            content += '<td>' + view.num + '</td>';
            content += '<td><a href="detail.do?num=' + view.num + '">' + view.title + '</a></td>';
            content += '<td>' + view.name + '</td>';
            content += '<td>' + view.bHit + '</td>';
            content += '<td>' + view.regdate + '</td>';
            content += '</tr>';
        });
        $('#list').html(content);
        $('#no-data').hide();
    }