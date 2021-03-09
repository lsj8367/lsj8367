
$(document).ready(function () {
    list1 = [1,2,3,4,5,6,7,8];
    list2 = [3,4,5,6];
    list3 = [7,8];
    list4 = [9];

    time1 = '3시간';
    time2 = '6시간';
    time3 = '12시간';
    time4 = '24시간';

    var a = function(arr, time){
        Highcharts.chart('container', {
        chart: {
            type: 'scatter',
            lineWidth: 0,
        },
        title: {
            text: '기온(°C) 그래프',
        },
        xAxis: {
            categories: [1, 2, 3, 4, 5, 6, 7, 8], //동적으로 수정하면됨
            title: {
                text: '시'
            }
        },
        yAxis: {
            title: {
                text: '기온 (°C)'
            }
        },
        plotOptions: {
            scatter: {
                dataLabels: {
                    enabled: true,
                    format: '{y} °C'
                },
                enableMouseTracking: false
            }
        },
    
        series: [
            {data: arr, // 기온
            name: time //시간
            //visible: false,
        }]
    })};

    a(list1, time1);
    $("#btn1").click(function(){
        a(list1, time1);
    });

    $("#btn2").click(function(){
        // a.series.visible = false;
        a(list2, time2);
    })
    $("#btn3").click(function(){
        a(list3, time3);
    });
    $("#btn4").click(function(){
        a(list4, time4);
    });
});
