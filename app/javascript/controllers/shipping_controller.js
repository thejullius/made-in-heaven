import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (event) => {
      event.preventDefault()

      const zipCode = document.getElementById("order_zip_code").value
      // todo i18n
      if (!/^[0-9]{8}$/.test(zipCode)) return alert('Por Favor, preencha o cep')

      const itemsId = [...document.querySelectorAll('[id^="order_order_items_attributes"][id$="_id"]')]
      const itemsQuantity = [...document.querySelectorAll('[id^="order_order_items_attributes"][id$="_quantity"]')]

      const items = itemsId.map((item, index) => ({ id: item.value, quantity: itemsQuantity[index].value }))
                           .filter(item => item.quantity !== '')
      // todo i18n
      if (items.length === 0) return alert('Por Favor, selecione ao menos um item')

      post('/orders/shipment_options', {
        body: { items, zip_code: zipCode },
        responseKind: 'turbo-stream'
      })
    })
  }
}
