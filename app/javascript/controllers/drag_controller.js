// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import Rails from "@rails/ujs";
import { Controller } from "stimulus"
import Sortable from "sortablejs";

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.sortable = Sortable.create(this.element,{
      onEnd: this.end.bind(this)
    })
  }
  end(event){
    let course_id = event.item.dataset.course_id
    console.log(event.item.dataset)
    let id = event.item.dataset.id
    let data = new FormData()
    data.append("position", event.newIndex + 1)

    let url = this.data.get("url")
    let mapUrl = { course_id: course_id, id: id}

    url = url.replace(/course_id|id/gi, function(matched){
      return mapUrl[matched];
    })

    Rails.ajax({
      url: url,
      type: 'PATCH',
      data: data
    })

  }
}
