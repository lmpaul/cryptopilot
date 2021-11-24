import Highcharts from 'highcharts/highstock';


(async () => {
  const item = document.querySelector('h1')
  const attribute = item.getAttribute('data-dashboard-id')
  // const data = await fetch('https://cdn.jsdelivr.net/gh/highcharts/highcharts@v7.0.0/samples/data/usdeur.json').then(r => r.json());
  const data = await fetch(`/api/values?dashboard_id=${attribute}`).then(r => r.json());

    // Create the chart
    Highcharts.chart('container', {
            chart: {
                zoomType: 'x'
            },
            title: {
                text: 'Your dashboard value over time'
            },
            subtitle: {
                text: document.ontouchstart === undefined ?
                    'Provided by Cryptopilot' : 'Pinch the chart to zoom in'
            },
            xAxis: {
                type: 'datetime'
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
                        radius: 2
                    },
                    lineWidth: 1,
                    states: {
                        hover: {
                            lineWidth: 1
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
