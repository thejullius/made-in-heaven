import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('input', () => this.cleanZipServiceSelect())
  }

  cleanZipServiceSelect() {
    const shipmentServiceSelect = document.getElementById('order_shipment_service')

    for (const option in shipmentServiceSelect.options) {
      shipmentServiceSelect.remove(option)
    }
    // todo i18n
    shipmentServiceSelect.add(new Option('Preencha o CEP e adicione itens e clique no botão abaixo', ''))
  }
}
