import Highcharts from 'highcharts';


(async () => {
  const item = document.querySelector('h1')
  const attribute = item.getAttribute('data-dashboard-id')
  // const data = await fetch('https://cdn.jsdelivr.net/gh/highcharts/highcharts@v7.0.0/samples/data/usdeur.json').then(r => r.json());
  const data = await fetch(`/dashboards/${attribute}/charts/pie`).then(r => r.json());

    // Create the
    Highcharts.chart('pie', {
    chart: {
        type: 'pie'
    },
    title: {
        text: 'Browser market shares. January, 2018'
    },
    subtitle: {
        text: 'Click the slices to view versions. Source: <a href="http://statcounter.com" target="_blank">statcounter.com</a>'
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
            name: "Browsers",
            colorByPoint: true,
            data: data
            }]
        });
})();
