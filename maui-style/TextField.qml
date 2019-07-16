/*
 * Copyright 2017 Marco Martin <mart@kde.org>
 * Copyright 2017 The Qt Company Ltd.
 *
 * GNU Lesser General Public License Usage
 * Alternatively, this file may be used under the terms of the GNU Lesser
 * General Public License version 3 as published by the Free Software
 * Foundation and appearing in the file LICENSE.LGPLv3 included in the
 * packaging of this file. Please review the following information to
 * ensure the GNU Lesser General Public License version 3 requirements
 * will be met: https://www.gnu.org/licenses/lgpl.html.
 *
 * GNU General Public License Usage
 * Alternatively, this file may be used under the terms of the GNU
 * General Public License version 2.0 or later as published by the Free
 * Software Foundation and appearing in the file LICENSE.GPL included in
 * the packaging of this file. Please review the following information to
 * ensure the GNU General Public License version 2.0 requirements will be
 * met: http://www.gnu.org/licenses/gpl-2.0.html.
 */


import QtQuick 2.6
import QtQuick.Window 2.1
import QtQuick.Controls 2.3 as Controls
import QtQuick.Templates 2.3 as T
import org.kde.kirigami 2.2 as Kirigami

T.TextField {
    id: controlRoot
    Kirigami.Theme.colorSet: Kirigami.Theme.View
    Kirigami.Theme.inherit: false

    implicitWidth: Math.max(200,
                            placeholderText ? placeholder.implicitWidth + leftPadding + rightPadding : 0)
                            || contentWidth + leftPadding + rightPadding
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             background ? Kirigami.Units.iconSizes.smallMedium : 0,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
/*
    color: controlRoot.enabled ? Kirigami.Theme.textColor : Kirigami.Theme.disabledTextColor
    selectionColor: Kirigami.Theme.highlightColor
    selectedTextColor: Kirigami.Theme.highlightedTextColor
    verticalAlignment: TextInput.AlignVCenter*/
    //Text.NativeRendering is broken on non integer pixel ratios
    renderType: Window.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
    
    color: enabled ? colorScheme.textColor : Qt.lighter(colorScheme.textColor, 1.4)
	selectionColor: highlightColor
	selectedTextColor: highlightedTextColor
	
	verticalAlignment: TextInput.AlignVCenter
	horizontalAlignment: Text.AlignHCenter
	
// 	cursorDelegate: CursorDelegate { }

    Controls.Label
	{
		id: placeholder
		x: control.leftPadding
		y: control.topPadding
		width: control.width - (control.leftPadding + control.rightPadding)
		height: control.height - (control.topPadding + control.bottomPadding)
		
		text: control.placeholderText
		font: control.font
		color: Qt.lighter(colorScheme.textColor, 1.4)
		opacity: 0.4
		horizontalAlignment: control.horizontalAlignment
		verticalAlignment: control.verticalAlignment
		visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
		elide: Text.ElideRight
	}	

	background: Rectangle 
	{        
		implicitWidth: unit * 120
		implicitHeight: iconSizes.big
		color: control.activeFocus ? Qt.lighter(colorScheme.backgroundColor, 1.4)
		: (control.hovered ? Qt.lighter(colorScheme.backgroundColor, 1.3) : colorScheme.backgroundColor)
		border.color: colorScheme.borderColor
		radius: radiusV
		border.width: unit		
	}
}
