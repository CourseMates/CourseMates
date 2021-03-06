﻿var filterTree = function (tf, e) {
    var tree = App.filesTreePanel,
                text = tf.getRawValue();

    tree.clearFilter();

    if (Ext.isEmpty(text, false)) {
        return;
    }

    if (e.getKey() === Ext.EventObject.ESC) {
        clearFilter();
    } else {
        var re = new RegExp(".*" + text + ".*", "i");

        tree.filterBy(function (node) {
            return re.test(node.data.text);
        });
    }
};

var clearFilter = function () {
    var field = App.TriggerField1,
                tree = App.filesTreePanel;

    field.setValue("");
    tree.clearFilter(true);
    tree.getView().focus();
};

var initSlidePanel = function () {
    this.setHeight(Ext.getBody().getHeight());

    if (!this.windowListen) {
        this.windowListen = true;

        this.el.alignTo(Ext.getBody(), 'tl-tr', [0, 0]);
        Ext.EventManager.onWindowResize(initSlidePanel, this);
    }
};