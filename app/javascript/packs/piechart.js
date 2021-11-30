import Highcharts, { chart } from 'highcharts';


const createPieChart = () => {
  const item = document.querySelector('h1');
  const attribute = item.getAttribute('data-dashboard-id');
  fetch(`/dashboards/${attribute}/charts/values`)
  .then(response => response.json())
  .then((data) => {
    data = data.pie
    const pie = Highcharts.chart('pie', {
    chart: {
        type: 'pie',
    },
    loading: {
      hideDuration:100,
      labelStyle:{"fontWeight": "bold", "position": "relative", "top": "45%"},
      showDuration:100,

    },
    title: {
        text: 'Your pilot repartition',
        style: ''
    },
    subtitle: {
        text: ''
    },
    accessibility: {
        announceNewData: {
            enabled: true
        },
        point: {
            valueSuffix: '%'
        }
    },
    plotOptions: {
        series: {
            dataLabels: {
                enabled: true,
                format: '{point.name}: {point.y:.1f}%'
            }
        }
    },
    tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
    },
    series: [
        {
            name: "Assets",
            colorByPoint: true,
            data: data
        }
    ]
    });
  });
}


createPieChart();
