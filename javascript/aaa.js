document.addEventListener('DOMContentLoaded', function(){
    var a = Highcharts.chart('container', {
        chart: {
            type: 'line'
        },
        title: {
            text: '기온(°C) 그래프',
        },
        xAxis: {
            categories: [1, 2, 3, 4, 5, 6, 7, 8],
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
            line: {
                dataLabels: {
                    enabled: true,
                    format: '{y} °C'
                },
                enableMouseTracking: false
            }
        },
    
        series: [
            {data: [null, 3, null, 7, null, 6.4, null, 3.2], //3시간
            //visible: false,
            name: '3시간'
        }, {
            data: [null, null, 5, null, null, null, 5.1, null], //6시간
            visible: false,
            name: '6시간',
        }, {
            data: [null, null, null, null, 7.5, null, null, null], //12시간
            visible: false,
            name: '12시간',
        }, {
            data: [-2, null, null, null, null, null, null, null], //24시간
            visible: false,
            name: '24시간',
        },]
        /*
                8개 온도를 받아오면
                array = [8개의 온도];
        
                a = arr[0,2,4,6]에 null 할당; 3시간
                b = arr[0,1,3,5,7]에 null 할당 6시간
                c arr[0,1,2,3,5,6,7]에 null할당 9시간
                d 0번째 빼고 모든 arr[]에 null 24시간
        */
    });

$("#btn1").on("click",function(){
    a.series[0].visible = false;
    console.log(a.series[0].visible);
    a;
});




})