package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
	"time"

	//"time"

	"github.com/antchfx/xmlquery"
)

func main() {

	args := os.Args

	// for i, arg := range args {
	// 	fmt.Printf("Args %d: %s\n", i, arg)
	// }

	if len(args) == 1 {
		exeName := args[0]
		exeName = filepath.Base(exeName)
		fmt.Printf("For Keil STM32 Add Makefile Support\n")
		fmt.Printf("Usage: %s [*.uvprojx]\n", exeName)
		return
	}

	keilProjectFilePath := args[1]
	content, err := ioutil.ReadFile(keilProjectFilePath)
	if err != nil {
		fmt.Println(err)
		return
	}

	//fmt.Printf("path: %s\n", keilProjectFilePath)
	//fmt.Printf("len: %d\n", len(content))

	doc, err := xmlquery.Parse(strings.NewReader(string(content)))
	doc = doc
	if err != nil {
		fmt.Println(err)
		return
	}

	// Makefile 输出内容
	makefileString := ""

	makefileString = makefileString + "# AUTO GENERATE BY KEIL2MAKEFILE\n"
	makefileString = makefileString + "# AT " + time.Now().String() + "\n\n"

	//处理头文件
	makefileString = makefileString + "#INCLUDE BEGIN\n"
	includes := xmlquery.Find(doc, "//VariousControls/IncludePath")
	for _, include := range includes {
		_Include := strings.TrimSpace(include.InnerText())
		//fmt.Printf("_Include: %s\n", _Include)

		// 空的忽略
		if _Include == "" {
			continue
		}

		makefileString = makefileString + handleInclude(_Include)
	}

	// 整合头文件
	makefileString = makefileString + `DIR_INCLUDE = $(patsubst %, -I%, $(INCLUDE_DIRS))` + "\n"
	makefileString = makefileString + "#INCLUDE END\n\n"

	//fmt.Printf("makefileString: \n%s\n", makefileString)

	// 处理源码
	makefileString = makefileString + "#SOURCE BEGIN\n"
	groups := xmlquery.Find(doc, "//Groups/Group")
	//fmt.Printf("%s\n", project)

	for _, group := range groups {
		//fmt.Printf("#%d %s\n", i, n.InnerText())
		_GName := ""
		if groupname := group.SelectElement("GroupName"); groupname != nil {
			//fmt.Printf("GroupName: %s\n", groupname.InnerText())
			_GName = strings.TrimSpace(groupname.InnerText())
			_GName = _GName
		}

		_files := xmlquery.Find(group, "//Files/File")

		for _, _file := range _files {
			_Name := ""
			_Type := ""
			_Path := ""

			if _filename := _file.SelectElement("FileName"); _filename != nil {
				//fmt.Printf("FileName: %s\n", strings.TrimSpace(_filename.InnerText()))
				_Name = strings.TrimSpace(_filename.InnerText())
			}

			if _filetype := _file.SelectElement("FileType"); _filetype != nil {
				//fmt.Printf("FileType: %s\n", _filetype.InnerText())
				_Type = strings.TrimSpace(_filetype.InnerText())
			}

			if _filepath := _file.SelectElement("FilePath"); _filepath != nil {
				//fmt.Printf("FilePath: %s\n", _filepath.InnerText())
				_Path = strings.TrimSpace(_filepath.InnerText())
			}

			makefileString = makefileString + handleSource(_Name, _Type, _Path)

		}
	}
	makefileString = makefileString + "#SOURCE END\n\n"

	// 获取文件名
	_base := filepath.Base(keilProjectFilePath)

	// 获取扩展名
	_ext := filepath.Ext(_base)

	// 去掉扩展名的文件名
	nameWithoutExt := _base[:len(keilProjectFilePath)-len(_ext)]

	nameWithoutExt = nameWithoutExt + ".mk"

	//fmt.Printf("makefileString: \n%s\n", makefileString)
	fmt.Printf("%s", makefileString)

	makefileByte := []byte(makefileString)
	if ioutil.WriteFile(nameWithoutExt, makefileByte, 0666) == nil {
		//fmt.Println("写入文件成功:", content)
	}
}

func replaceSeparator(p string) string {
	s := strings.Replace(p, "\\", "/", -1)
	return s
}

func handleInclude(_Include string) string {
	_IncludePaths := strings.Split(_Include, ";")

	_includeString := ""
	for _, _path := range _IncludePaths {
		_path = strings.TrimSpace(_path)
		_path = replaceSeparator(_path)
		if _path == "" {
			continue
		}

		//_includeString = _includeString + fmt.Sprintf("INCLUDE_DIRS+=%s\n", _path)
		_includeString = _includeString + fmt.Sprintf("INCLUDE_DIRS+=$(KEILMK_DIR)/%s\n", _path)

	}

	return _includeString
}

func handleSource(_Name string, _Type string, _Path string) string {
	//fmt.Printf("FileName: %s\n", _Name)
	//fmt.Printf("FileType: %s\n", _Type)
	//fmt.Printf("FilePath: %s\n", _Path)
	//return ""

	//_Prefix := "../u/i"
	//_Prefix = _Prefix

	// windows \ 转 unix /
	_Path = replaceSeparator(_Path)

	s := ""

	if _Type == "1" {
		// c文件
		s = s + fmt.Sprintf("SRC_C+=$(KEILMK_DIR)/%s\n", _Path)
	}

	if _Type == "2" {
		// 汇编文件
		s = s + fmt.Sprintf("SRC_ASM+=$(KEILMK_DIR)/%s\n", _Path)
	}

	return s
}
