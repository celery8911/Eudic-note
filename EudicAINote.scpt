tell application "System Events"
	tell process "LightPeek_en"
		tell window "取词 "
			try
				-- 获取UI element 1下的所有组
				set allGroups to groups of UI element 1 of scroll area 1 of group 1 of group 1
				set foundCopyButton to false
				-- 遍历每个组查找"复制"按钮
				repeat with aGroup in allGroups
					try
						set copyButton to UI element "复制" of aGroup
						-- 如果找到按钮，设置标志
						set foundCopyButton to true
						-- 点击复制按钮
						click copyButton
						delay 0.01
						-- 点击笔记按钮打开笔记编辑窗口
						click button 5
						exit repeat -- 找到后退出循环
					on error
						-- 这个组中没有找到复制按钮，继续下一个
					end try
				end repeat
				
				-- 如果遍历完所有组还没找到，显示提示
				if not foundCopyButton then
					display dialog "AI解释的复制按钮未找到" buttons {"确定"} default button "确定" with icon caution
					return
				end if
				
			on error errMsg
				-- 捕获任何其他错误
				display dialog "查找按钮时出错: " & errMsg buttons {"确定"} default button "确定" with icon stop
				return
			end try
			
		end tell
	end tell
	delay 0.1
	tell process "Eudic"
		tell window "我的笔记"
			-- 检查text area 1是否为空
			set textContent to value of text area 1 of scroll area 1
			if textContent is not "" then
				return
			end if
			keystroke "v" using {command down}
			click button "保存 (⌘↩︎)"
			delay 0.01
		end tell
		tell window 1
			click button 1
		end tell
	end tell
end tell