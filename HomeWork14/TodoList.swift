import Foundation
import RealmSwift
import CoreData

class Todo: Object{//класс одного дела
    @objc dynamic var whatTodo:String //что нужно сделать
    @objc dynamic var whenTodo:Date //когда сделать
    
    init(what: String, when: Date) {
        self.whatTodo=what
        self.whenTodo=when
    }
    
    init(_ what: String) {
        self.whatTodo=what
        self.whenTodo=Date()
    }
    
    required init() {
        self.whatTodo=""
        self.whenTodo=Date()
        //fatalError("init() has not been implemented")
    }
    
}

class TodoList{//класс коллекция дел, со своими функциями
    private var todoList : [Todo] = [] //список дел
    
    public var count:Int{
        get{
            return todoList.count
        }
    }
    
    public func addTodo(_ todo: Todo){
        todoList.append(todo)
    }
    
    public func getTodoAt(_ index: Int) ->Todo?{
        if index<0 || index>=count { return nil }
        return todoList[index]
    }
    
    public func removeTodAt(_ index: Int){
        if index<0 || index>=count { return}
        todoList.remove(at: index)
    }
    
    public func SaveToRealm(){
        let realm = try! Realm()
        try! realm.write{
            for todo in todoList{
                realm.add(todo)
            }
        }
    }
    
    public func ReadFromRealm(){//вот такая реализация мне что то не нравится
        let realm = try! Realm()
        todoList.removeAll()
        let todoListRead=realm.objects(Todo.self)//читаем объекты
        for todo in todoListRead{
            self.todoList.append(todo)
        }
    }
    
    public func SaveToCoredata() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
            //appDelegate.managedObjectContext!
        for todo in todoList{
            let item =  NSEntityDescription.insertNewObject(forEntityName: "TodoListEntity", into: managedContext) as! TodoListEntity
            
            item.what=todo.whatTodo
            item.when=todo.whenTodo
            
            //item.setValue(todo.whatTodo, forKey: "what")
            //item.setValue(todo.whenTodo, forKey: "when")
        }
    }
    
    public func ReadFromCoredata(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"TodoListEntity")
        
        let fetchedResults = try!managedContext.fetch(fetchRequest) as? [NSManagedObject]
        todoList.removeAll()
        if let results = fetchedResults {
            for result in results{
                let todo=Todo(what: result.value(forKey: "what") as! String, when: result.value(forKey: "when") as! Date)
                todoList.append(todo)
            }
         }
    }
    
}
