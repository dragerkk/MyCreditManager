//
//  main.swift
//  MyCreditManager
//
//  Created by 강주원 on 2022/11/18.
//

import Foundation

//https://yagomacademy.notion.site/iOS-ba2d0c0bb0b949c896cc28567706e969

struct Student {
	var name: String = ""
	var score: [String:String] = [:]
	
	func getAverage(grade: [String:String]) -> Float {
		var sum:Float = 0
		grade.forEach { gr in
			sum += scoreTable[gr.value]!
		}
		return sum / Float(grade.count)
	}
}

var input: String = ""
var scoreTable: [String:Float] = ["A+":4.5, "A":4, "B+":3.5, "B":3, "C+":2.5, "C":2, "D+":1.5, "D":1, "F":0]
var student: [Student] = []

while input != "X" {
	print("원하는 기능을 입력해주세요")
	print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
	input = readLine()!
	
	switch input {
	case "1": //학생추가
		print("추가할 학생의 이름을 입력해주세요")
		let tempName = readLine()!
		if tempName == "" {
			print("입력이 잘못되었습니다. 다시 확인해주세요.")
			continue
		} else {
			var checkExist: Bool = false
			
			for stud in student {
				if checkExist == true {
					break
				}
				if stud.name == tempName {
					checkExist = true
					print("\(tempName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
				}
			}
			
			if checkExist == false {
				student.append(Student(name: tempName))
				print("\(tempName) 학생을 추가했습니다.")
			}
		}
	
	case "2": //학생 삭제
		print("삭제할 학생의 이름을 입력해주세요")
		let tempName = readLine()!
		if tempName == "" {
			print("입력이 잘못되었습니다. 다시 확인해주세요")
			continue
		} else {
			var checkExist: Bool = false
			for i in 0..<student.count {
				if student[i].name == tempName {
					student.remove(at: i)
					print("\(tempName) 학생을 삭제하였습니다.")
					checkExist = true
					break
				}
			}
			if checkExist == false {
				print("\(tempName) 학생을 찾지 못했습니다.")
			}
		}
		
	case "3": //성적추가(변경)
		print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
		print("입력예) Mickey Swift A+")
		print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
		
		let input = readLine()!.split(separator: " ").map{String($0)}
		
		if input.count != 3 {
			print("입력이 잘못되었습니다. 다시 확인해주세요.")
			break
		}
		if !scoreTable.keys.contains(input[2]) {
			print("성적 입력이 잘못되었습니다. 다시 확인해주세요.")
			break
		}
		var checkExist: Bool = false
		for i in 0..<student.count {
			if student[i].name == input[0] {
				student[i].score[input[1]] = input[2]
				print(student)
				print("\(input[0]) 학생의 \(input[1]) 과목이 \(input[2])로 추가(변경)되었습니다.")
				checkExist = true
				break
			}
		}
		if checkExist == false {
			print("\(input[0]) 학생을 찾지 못했습니다.")
		}
		
	case "4":
		print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
		print("입력예) Mickey Swift")
		
		let input = readLine()!.split(separator: " ").map{String($0)}
		if input.count != 2 {
			print("입력이 잘못되었습니다. 다시 확인해주세요.")
			break
		}
		var checkExist: Bool = false
		for i in 0..<student.count {
			if student[i].name == input[0] {
				student[i].score.removeValue(forKey: input[1])
				print("\(input[0]) 학생의 \(input[1]) 과목의 성적이 삭제되었습니다.")
				checkExist = true
				break
			}
		}
		if checkExist == false {
			print("\(input[0]) 학생을 찾지 못했습니다.")
		}
		
	case "5":
		print("평점을 알고싶은 학생의 이름을 입력해주세요")
		let name = readLine() ?? ""
		if name == "" {
			print("입력이 잘못되었습니다. 다시 확인해주세요.")
			break
		}
		
		var checkExist: Bool = false
		
		for stud in student {
			if stud.name == name {
				checkExist = true
				for score in stud.score {
					print("\(score.key): \(score.value)")
				}
				if stud.score.count == 0 {
					print("\(name) 학생의 성적이 입력되어 있지 않습니다.")
				} else {
					let avr = stud.getAverage(grade: stud.score)
					print("평점 : \(String(format: "%.2f", avr))")
				}
			}
		}
		if checkExist == false {
			print("\(name) 학생을 찾지 못했습니다.")
		}
		
	case "X":
		print("프로그램을 종료합니다...")
		
	default:
		print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
	}
}

//print(student)
