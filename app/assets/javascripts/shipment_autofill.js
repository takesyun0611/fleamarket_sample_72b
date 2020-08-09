$(function() {
  $(function() {
    return $('#shipment_postal_code').jpostal({
      postcode: ['#shipment_postal_code'],
      address: {
        '#shipment_prefecture': '%3',
        '#shipment_city': '%4%5%6%7',
      },
    });
  });
});