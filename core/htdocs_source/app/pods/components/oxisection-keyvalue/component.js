import Component from '@glimmer/component';
import { computed } from '@ember/object';
import types from "../oxivalue-format/types";

export default class OxisectionKeyvalueComponent extends Component {
    @computed("args.def.data")
    get items() {
        let items = this.args.def.data || [];
        for (const i of items) {
            if (i.format === 'head') { i.isHead = 1 }
        }
        // hide items where value (after formatting) is empty
        return items.filter(item => types[item.format || 'text'](item.value) !== '');
    }
}