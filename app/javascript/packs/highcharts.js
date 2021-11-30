import Highcharts from 'highcharts';


(async () => {
  const item = document.querySelector('h1')
  const attribute = item.getAttribute('data-dashboard-id')
  // const data = await fetch('https://cdn.jsdelivr.net/gh/highcharts/highcharts@v7.0.0/samples/data/usdeur.json').then(r => r.json());
  const result = await fetch(`/dashboards/${attribute}/charts/values`).then(r => r.json());
  const data = result.value
    // Create the chart
    Highcharts.chart('container', {
            chart: {
                zoomType: 'x'
            },
            title: {
                text: 'Your pilot value over time',
                style: ''
            },
            subtitle: {
                text: document.ontouchstart === undefined ?
                    'All assets' : 'Pinch the chart to zoom in'
            },
            xAxis: {
                type: 'category'
            },
            yAxis: {
                title: {
                    text: 'Value'
                }
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0, Highcharts.getOptions().colors[0]],
                            [1, Highcharts.color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                        ]
                    },
                    marker: {
                        radius: 4
                    },
                    lineWidth: 3,
                    states: {
                        hover: {
                            lineWidth: 2
                        }
                    },
                    threshold: null
                }
            },

            series: [{
                type: 'area',
                name: 'USD',
                data: data
            }]
        });
})();
