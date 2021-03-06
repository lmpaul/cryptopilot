import Highcharts from 'highcharts';

const buildCharts = (asset) => {
  const item = document.querySelector('h1');
  const attribute = item.getAttribute('data-dashboard-id');
  const key = asset
  fetch(`/dashboards/${attribute}/charts/sparkline`)
  .then(response => response.json())
  .then((data) => {

      data = data[key]
      Highcharts.chart(`${key}`, {
            chart: {
                zoomType: ''
            },
            title: {
                text: '',
                style: ''
            },
            subtitle: {
                text: document.ontouchstart === undefined ?
                    'Asset market price' : 'Pinch the chart to zoom in'
            },
            xAxis: {
                visible: false
            },
            yAxis: {
                visible: false
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
                    lineWidth: 2,
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
      })
    });
}

const createSparklines = () => {
  const cards = document.querySelectorAll(".asset");
  const assets = [];
  cards.forEach(card => assets.push(card.getAttribute('data-asset')));
  assets.forEach(asset => buildCharts(asset));
}

export { createSparklines };
